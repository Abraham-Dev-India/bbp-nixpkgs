{ stdenv
, config
, patchelf
}:

let
  has_icc = config ? intel_compiler_path && config.intel_compiler_path != null;
  compiler_path = if (has_icc) then config.intel_compiler_path else "";

  wrapper = stdenv.mkDerivation {
    name = "intel-mkl";
    unpackPhase = ''echo "no sources"'';
    dontBuild = true;
    dontStrip = true;
    installPhase = ''
      mkdir -p $out/lib;

      pushd ${compiler_path}/mkl/lib/intel64
      for i in * ; do
        echo "Nixify $i under ${compiler_path}/mkl/lib/intel64"
        cp -f -L  "${compiler_path}/mkl/lib/intel64/$i" "$out/lib/$i" || true
        ${patchelf}/bin/patchelf --set-interpreter ${stdenv.glibc}/lib/ld-linux-x86-64.so.2 $out/lib/$i || /bin/true
        ${patchelf}/bin/patchelf --set-rpath "${stdenv.cc.cc}/lib:${stdenv.glibc}/lib:$out/lib" "$out/lib/$i" || /bin/true
      done
      popd

      cp -r ${compiler_path}/mkl/include $out/include
    '';

    preferLocalBuild = true;
    passthru = {
      isMKL = true;
      gcc = stdenv.cc;
    };
  };

in
  if (has_icc) then wrapper else null
