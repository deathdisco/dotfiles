with import <nixpkgs> {};

mkShell {
  buildInputs = [ nodejs ] ++ (with ocamlPackages_4_02; [ ocaml ninja merlin ]);

  shellHook = ''
  	# install npm packages to pwd
  	npm set prefix .npm-global
    export PATH="$PWD/.npm-global/bin:$PWD/node_modules/.bin:$PATH"
  '';
}