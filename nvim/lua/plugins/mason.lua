return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "hadolint",
        "markdownlint",
        "nginx-language-server",
        "prettier",
        "rubocop",
        "shellcheck",
        "shfmt",
        "solargraph",
        "sql-formatter",
        "stylua",
        "tflint",
        "xmlformatter",
      },
    },
  },
}
