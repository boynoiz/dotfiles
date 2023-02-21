return {
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      local logo = [[
            ╗W        ¢_   
          φ╣╣╣▓       ║╣▓,  
        j╔└▓╣╣╣╣╦     ║╣╣╣▓ 
        ╠╠▒_╫╣╣╣╣▌    ║╣╣╣╣ 
        ╠╠╠╠╔╙╣╣╣╣▓╕  ║╣╣╣╣ 
        ╠╠╠╠╠  ╫╣╣╣╣▌ ║╣╣╣╣ 
        ╠╠╠╠╠   ╙╣╣╣╣▓╕╫╣╣╣ 
        ╠╠╠╠╠     ╣╣╣╣╣▄╙╣╣ 
        '╠╠╠╠      ╚╣╣╣╣▓┬╝ 
          '╝╠       '▓╣╣╝   
            `         ╙     
    ]]
      opts.section.header.val = vim.split(logo, "\n", { trimempty = true })
    end,
  },
}
