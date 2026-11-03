function sudo --wraps sudo --description "sudo with Jurassic Park security"
    # These flags don't need a password check first, so pass them straight through
    if test (count $argv) -eq 0
        command sudo
        return $status
    end
    for flag in -n --non-interactive -k -K -h --help -V --version
        if contains -- $flag $argv
            command sudo $argv
            return $status
        end
    end

    # Ask for the password (sudo gives 3 tries). If it fails, show the magic word.
    if not command sudo -v
        magic_word
        return 1
    end

    command sudo $argv
end
