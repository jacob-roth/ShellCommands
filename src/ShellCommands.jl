__precompile__()

## REFERENCE: https://discourse.julialang.org/t/using-as-a-wildcard-in-backtick-commands/6094/5

module ShellCommands

export @cmd_cmd, @ps_cmd, @busybox_cmd, @sh_cmd

macro cmd_cmd(s_str)
    s_expr = Meta.parse(string('"', escape_string(s_str), '"'))
    return esc(:(Cmd(Base.cmd_gen(("cmd", "/s", "/c", string('"', $s_expr, '"'))), windows_verbatim=true)))
end

macro ps_cmd(s_str)
    s_expr = Meta.parse(string('"', escape_string(s_str), '"'))
    return esc(:(Base.cmd_gen(("powershell", "-Command", $s_expr))))
end

macro busybox_cmd(s_str)
    s_expr = Meta.parse(string('"', escape_string(s_str), '"'))
    return esc(:(Base.cmd_gen(("busybox", "sh", "-c", $s_expr))))
end

macro sh_cmd(s_str)
    s_expr = Meta.parse(string('"', escape_string(s_str), '"'))
    return esc(:(Base.cmd_gen(("sh", "-c", $s_expr))))
end

end