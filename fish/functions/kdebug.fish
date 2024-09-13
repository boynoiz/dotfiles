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

    if test (count $argv) -gt 0
        echo "Usage: kdebug [options]"
        echo "Options:"
        echo "  -c/--context <context>    Specify the kubectl context (default: current context)"
        echo "  -n/--namespace <namespace> Specify the namespace (default: current namespace)"
        echo "  -t/--target <container>   Specify the target container to debug"
        echo ""
        echo "Example:"
        echo "  kdebug -c staging -n site_a -t app_container"
        echo ""
        echo "This will create a debug pod with an auto-generated name in the 'site_a' namespace"
        echo "of the 'staging' context, targeting the 'app_container' container."
        echo "The debug pod will be automatically removed after exit."
        return 1
    end

    set -l random_suffix (tr -dc A-Za-z0-9 </dev/urandom | head -c 13)
    set -l debug_pod_name "netshoot-$random_suffix"

    eval kubectl $context_arg $namespace_arg debug -it --rm --image=nicolaka/netshoot $target_arg $debug_pod_name
end
