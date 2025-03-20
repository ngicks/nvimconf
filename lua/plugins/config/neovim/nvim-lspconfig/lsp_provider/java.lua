local M = {}

local make_opts = function(defaults)
  -- use this function notation to build some variables
  local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle", ".project" }
  local root_dir = require("jdtls.setup").find_root(root_markers)
  local next_up = root_dir
  while next_up ~= nil and next_up ~= "" and next_up ~= "/" do
    next_up = vim.fs.root(vim.fs.dirname(root_dir), root_markers)
    if next_up ~= nil and next_up ~= "" then
      root_dir = next_up
    end
  end
  -- calculate workspace dir
  local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
  local workspace_dir = vim.fn.stdpath "data" .. "/site/java/workspace-root/" .. project_name
  vim.fn.mkdir(workspace_dir, "p")

  -- validate operating system
  if not (vim.fn.has "mac" == 1 or vim.fn.has "unix" == 1 or vim.fn.has "win32" == 1) then
    vim.notify("jdtls: Could not detect valid OS", vim.log.levels.ERROR)
  end

  return {
    cmd = {
      vim.fn.expand "$JAVA_HOME/bin/java",
      "-Declipse.application=org.eclipse.jdt.ls.core.id1",
      "-Dosgi.bundles.defaultStartLevel=4",
      "-Declipse.product=org.eclipse.jdt.ls.core.product",
      "-Dlog.protocol=true",
      "-Dlog.level=ALL",
      "-javaagent:" .. vim.fn.expand "$MASON/share/jdtls/lombok.jar",
      "-Xms1g",
      "--add-modules=ALL-SYSTEM",
      "--add-opens",
      "java.base/java.util=ALL-UNNAMED",
      "--add-opens",
      "java.base/java.lang=ALL-UNNAMED",
      "-jar",
      vim.fn.expand "$MASON/share/jdtls/plugins/org.eclipse.equinox.launcher.jar",
      "-configuration",
      vim.fn.expand "$MASON/share/jdtls/config",
      "-data",
      workspace_dir,
    },
    root_dir = root_dir,
    settings = {
      java = {
        home = vim.fn.expand "$JAVA_HOME",
        runtimes = {
          {
            name = "JavaSE-11",
            path = vim.fn.expand "$HOME/.local/jdk-11.0.2",
          },
          {
            name = "JavaSE-17",
            path = vim.fn.expand "$HOME/.local/jdk-17.0.2",
            default = true,
          },
          {
            name = "JavaSE-21",
            path = vim.fn.expand "$HOME/.local/jdk-21.0.2",
          },
          {
            name = "JavaSE-23",
            path = vim.fn.expand "$HOME/.local/jdk-23.0.2",
          },
        },
        eclipse = { downloadSources = true },
        configuration = { updateBuildConfiguration = "interactive" },
        maven = { downloadSources = true },
        -- gradle = {
        --   buildServer = {
        --     enabled = "off",
        --   },
        -- },
        implementationsCodeLens = { enabled = true },
        referencesCodeLens = { enabled = true },
        inlayHints = { parameterNames = { enabled = "all" } },
        signatureHelp = { enabled = true },
        import = {
          gradle = {
            arguments = { "-x", "benchmarks:run", "-Dorg.gradle.ignoreBuildJavaVersionCheck=true" },
            ignoredProjects = { "benchmarks" },
            enabled = true,
            java = {
              home = vim.fn.expand "$HOME/.local/jdk-17.0.2",
            },
            wrapper = {
              enabled = true,
            },
          },
        },
        completion = {
          favoriteStaticMembers = {
            "org.hamcrest.MatcherAssert.assertThat",
            "org.hamcrest.Matchers.*",
            "org.hamcrest.CoreMatchers.*",
            "org.junit.jupiter.api.Assertions.*",
            "java.util.Objects.requireNonNull",
            "java.util.Objects.requireNonNullElse",
            "org.mockito.Mockito.*",
          },
        },
        sources = {
          organizeImports = {
            starThreshold = 9999,
            staticStarThreshold = 9999,
          },
        },
      },
    },
    init_options = {
      bundles = {
        vim.fn.expand "$MASON/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar",
        -- unpack remaining bundles
        (table.unpack or unpack)(vim.split(vim.fn.glob "$MASON/share/java-test/*.jar", "\n", {})),
      },
    },
    handlers = {
      ["$/progress"] = function() end, -- disable progress updates.
      extendedClientCapabilities = {
        clientHoverProvider = false,
      },
    },
    filetypes = { "java" },
    on_attach = function(...)
      --      require("jdtls").setup_dap { hotcodereplace = "auto" }
      defaults.on_attach(...)
    end,
  }
end

M.config = function(servers, defaults)
  vim.api.nvim_create_autocmd("Filetype", {
    pattern = "java", -- autocmd to start jdtls
    callback = function()
      local opts = make_opts(defaults)
      if opts.root_dir and opts.root_dir ~= "" then
        require("jdtls").start_or_attach(vim.tbl_deep_extend("keep", opts, defaults))
      else
        vim.notify("jdtls: root_dir not found. Please specify a root marker", vim.log.levels.ERROR)
      end
    end,
  })
  -- create autocmd to load main class configs on LspAttach.
  -- This ensures that the LSP is fully attached.
  -- See https://github.com/mfussenegger/nvim-jdtls#nvim-dap-configuration
  vim.api.nvim_create_autocmd("LspAttach", {
    pattern = "*.java",
    callback = function(args)
      --      local client = vim.lsp.get_client_by_id(args.data.client_id)
      -- ensure that only the jdtls client is activated
      --     if client and client.name == "jdtls" then
      --       require("jdtls.dap").setup_dap_main_class_configs()
      --   end
    end,
  })
end

return M
