function kdebug
    argparse 'c/context=' 'n/namespace=' 't/target=' -- $argv
    or return

    set -l context_arg ""
    set -l namespace_arg ""
    set -l target_arg ""

    if set -q _flag_context
        set context_arg "--context $_flag_context"
    end

    if set -q _flag_namespace
        set namespace_arg "--namespace $_flag_namespace"
    end

    if set -q _flag_target
        set target_arg "--target $_flag_target"
    end

    if test (count $argv) -eq 0
        echo "Usage: kdebug [options] <pod-name>"
        echo "Options:"
        echo "  -c/--context <context>    Specify the kubectl context"
        echo "  -n/--namespace <namespace> Specify the namespace"
        echo "  -t/--target <container>   Specify the target container"
        return 1
    end

    set -l pod_name $argv[1]

    eval kubectl $context_arg $namespace_arg debug -it --image=nicolaka/netshoot $target_arg $pod_name
end
