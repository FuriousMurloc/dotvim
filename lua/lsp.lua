local on_attach = function(client, bufnr)
    vim.lsp.completion.enable(true, client.id, bufnr, {
        autotrigger = true,
        convert = function(item)
            return { abbr = item.label:gsub('%b()', '') }
        end,
    })
    vim.keymap.set('i', '<C-space>', vim.lsp.completion.get, { desc = 'trigger autocompletion' })
end


vim.lsp.config('lua_ls',{
    on_attach = on_attach ,
    filetypes = { 'lua' },
    cmd = { 'lua-language-server' },
    root_markers = {
        ".luarc.json",
        ".luarc.jsonc",
        ".luacheckrc",
        ".stylua.toml",
        ".git",
      },
      settings = {
        Lua = {
          runtime = {
            version = 'LuaJIT',
          }
        }
      }
})

vim.lsp.config('clangd',{
    cmd = { 'clangd', '--background-index', '--clang-tidy' },
    filetypes = { 'c', 'cpp' },
    on_attach = on_attach
})

vim.lsp.config('zls', {
    on_attach = on_attach,
    cmd = { 'zls' },
    filetypes = { 'zig' },
    settings = {
        zls = {

            semantic_tokens = "partial",
            zig_lib_path = "/home/aleix/srcs/zig/lib/"

        }
    }
})



--activar lsps
vim.lsp.enable({ "lua_ls", "clangd" , "zls", "elixirls"})

