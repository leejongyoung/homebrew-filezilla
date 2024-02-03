cask "filezilla" do
    version "3.66.4"
  
    if Hardware::CPU.intel?
      sha256 "95ac7c083ef59d9b451164b97603acd8a23060c825e928fccf59d81684f2994f"
      url "https://download.filezilla-project.org/client/FileZilla_#{version}_macos-x86.app.tar.bz2"
    else
      sha256 "f050b503ab367a95f4a9575acd966b5164d869be5ad31888e063f7a7d0b875e2"
      url "https://download.filezilla-project.org/client/FileZilla_#{version}_macos-arm64.app.tar.bz2"
    end
  
    name "FileZilla"
    desc "Fast and reliable FTP, FTPS, and SFTP client"
    homepage "https://filezilla-project.org/"
  
    app "FileZilla.app"

    postflight do
      icon_path = "#{Caskroom.path}/filezilla/#{version}/FileZilla.icns"
      app_path = "/Applications/FileZilla.app"
      system_command "mkdir", args: ["-p", File.dirname(icon_path)]
      system_command "curl", args: ["-s", "-o", icon_path, "https://raw.githubusercontent.com/leejongyoung/homebrew-cask/custom/FileZilla.icns"]
      system_command "xattr", args: ["-d", "com.apple.quarantine", app_path]
      system_command "cp", args: [icon_path, "#{app_path}/Contents/Resources/FileZilla.icns"]
      system_command "touch", args: [app_path]
    end  
  
    zap trash: [
      "~/Library/Application Support/FileZilla",
      "~/Library/Preferences/org.filezilla-project.filezilla.plist",
      "~/Library/Saved Application State/org.filezilla-project.filezilla.savedState",
      "~/Library/Logs/FileZilla",
    ]
  end
  