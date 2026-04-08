default:
  @just --list

# Run mdbook locally
serve:
  mdbook serve \
    --open

# Run checks against the repository
check:
  # check Nix files
  nixfmt --check **.nix

  # check markdown files
  mdl --git-recurse .


# Format all nix files
nix-fmt:
  nixfmt **.nix
