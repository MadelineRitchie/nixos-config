{ config, pkgs, ... }:
{
	nixpkgs.config = {
		allowUnfree = true;
		permittedInsecurePackages = [
			"electron-25.9.0"
		];
	};

	home.username = "madeline";
	home.homeDirectory = "/home/madeline";
	home.stateVersion = "23.11";

	home.packages = with pkgs; [
		obsidian
		jetbrains.rider
		ungoogled-chromium
                vscode.fhs
                cinny-desktop
	];

	home.file = {
		# # Building this configuration will create a copy of 'dotfiles/screenrc' in
		# # the Nix store. Activating the configuration will then make '~/.screenrc' a
		# # symlink to the Nix store copy.
		# ".screenrc".source = dotfiles/screenrc;

		# # You can also set the file content immediately.
		# ".gradle/gradle.properties".text = ''
		#   org.gradle.console=verbose
		#   org.gradle.daemon.idletimeout=3600000
		# '';
	};

	dconf.settings = {
		"org/virt-manager/virt-manager/connections" = {
			autoconnect = ["qemu:///system"];
			uris = ["qemu:///system"];
		};

	};
	imports = [
		./shared.nix
	];
}
