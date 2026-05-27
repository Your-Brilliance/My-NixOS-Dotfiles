return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function()
    local npairs = require("nvim-autopairs")
    
    npairs.setup({
      check_ts = true, 
    })

    local Rule = require("nvim-autopairs.rule")
    local cond = require("nvim-autopairs.conds")

    npairs.add_rules({
      Rule("<", ">", { "cpp", "rust" })
        :with_pair(cond.before_regex("%a+"))
        :with_move(function(opts)
          return opts.char == ">"
        end),
    })
  end,
}
