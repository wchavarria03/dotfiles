return {
  cmd = { 'beancount-language-server', '--stdio' },
  filetypes = { 'beancount', 'bean' },
  root_markers = { "beanfile", ".git" },
  single_file_support = true,
  init_options = {},
  settings = {
    init_options = {
      journalFile = "~/personal/finances/main.beancount",
    },
    beancount = {
      journalFile = "~/personal/finances/main.beancount",
    },
  },
}
