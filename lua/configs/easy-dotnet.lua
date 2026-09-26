return {
    'GustavEikaas/easy-dotnet.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    lazy = true,
    ft = {
        'cs',
        'xml',
        'razor'
    },
    config = function ()
        require 'easy-dotnet'.setup()
    end
}
