with import <nixpkgs-unstable> {
  config.allowUnfree = true;
  cudaSupport = true;
};

let
  pythonWithPackages = python3.withPackages (ps: [ ps.torch ]);
in
mkShell {
  buildInputs = [
    pythonWithPackages
    cudatoolkit
  ];

  # Optional: Set up necessary environment variables for CUDA
  shellHook = ''
    export CUDA_HOME=${cudatoolkit}
    export LD_LIBRARY_PATH=$CUDA_HOME/lib64:$LD_LIBRARY_PATH
    export PATH=$CUDA_HOME/bin:$PATH
  '';
}
