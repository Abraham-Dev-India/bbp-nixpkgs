{
    pkgs
}:

rec {

      hpc = pkgs.envModuleGen {
            name = "HPCrelease";
            description = "load BBP HPC environment generated by nix";
            packages = [ 
                            pkgs.functionalizer 
                            pkgs.touchdetector
                            pkgs.mvdtool
                            pkgs.highfive
                            pkgs.bluebuilder
                            pkgs.flatindexer

                            # cellular sim
                            pkgs.coreneuron
                            pkgs.mod2c
                            pkgs.neurodamus
                            pkgs.neuron
                            pkgs.reportinglib
        
                            # sub cellular sim
                            pkgs.steps-mpi

                            #utils
                            pkgs.bbp-mpi
                            
                            #python env for scientists
                            pkgs.python27Full                            
                            pkgs.python27Packages.numpy
                            pkgs.python27Packages.matplotlib
                            pkgs.python27Packages.pandas
                                                        
                       ];
            extraContent = "prepend-path BBP_HOME $targetEnv/";                       
      };

      hpc-bgq = pkgs.envModuleGen {
            name = "HPCrelease";
            description = "load BBP HPC environment on BGQ module generated by nix";
            packages = [ 
                            pkgs.functionalizer 
                            pkgs.touchdetector
                            pkgs.bluebuilder                            
                            pkgs.highfive
                            pkgs.mvdtool                            

                            # cellular sim
                            pkgs.coreneuron
                            pkgs.mod2c
                            pkgs.neurodamus
                            pkgs.neuron
                            pkgs.reportinglib
                       ];
            extraContent = "prepend-path BBP_HOME $targetEnv/";
      };


      python27 = with pkgs; envModuleGen rec {
            name = "python-2.7";
            prefixDir= "nix";
            description = "python 2.7 module generated by nix";
            packages = let pythonPkgs = python27Packages;
                         in
                        [ 
                            python 
                            pythonPkgs.numpy
                            pythonPkgs.pandas                            
                            pythonPkgs.pycurl
                            pythonPkgs.h5py
                       ];
      };
      
      python34 = pkgs.envModuleGen rec {
            name = "python-3.4";
            prefixDir= "nix";
            description = "python 3.4 module generated by nix";
            packages = let pythonPkgs = pkgs.python34Packages;
                         in
                        [ 
                            pkgs.python34 
                            pythonPkgs.numpy
                            pythonPkgs.pandas                            
                            pythonPkgs.pycurl
                            pythonPkgs.h5py
                       ];
      };    


      rust = pkgs.envModuleGen rec {
            name = "rust-1.2";
            prefixDir= "nix";
            description = "rust platform module generated by nix";
            packages = [ 
                            pkgs.rustc
                            pkgs.cargo 
                       ];
      };    
 

      golang = pkgs.envModuleGen rec {
            name = "go-1.5";
            prefixDir= "nix";
            description = "golang and packages module generated by nix";
            packages = [ 
                            pkgs.goPackages.go
                            pkgs.goPackages.net
                            pkgs.goPackages.osext 
                       ];
      };  
      
      
      cmake = pkgs.envModuleGen rec {
            name = "cmake-3.0";
            prefixDir= "nix";
            description = "cmake 3.0 module generated by nix";
            packages = [ 
                            pkgs.cmake 
                       ];
      };    
      
      gcc52 = pkgs.envModuleGen rec {
            name = "gcc-5.2.0";
            prefixDir= "nix";
            description = "gcc 5.2.0 module generated by nix";
            packages = [ 
                            pkgs.gcc5 
                       ];
      };   
      
      
    R = pkgs.envModuleGen rec {
            name = "R-3.2.2";
            prefixDir= "nix";
            description = "R module generated by nix";
            packages = [ 
                            pkgs.R
                       ];
      };   

}
