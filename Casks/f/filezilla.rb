cask "filezilla" do
    version "3.66.5"
  
    if Hardware::CPU.intel?
      sha256 "867331bcab7cd35750390e1df10e41d4032065b57dbbfa83fad2c63eb1c5c21f"
      url "https://download.filezilla-project.org/client/FileZilla_#{version}_macos-x86.app.tar.bz2"
    else
      sha256 "061436db2cc1054522a7092e5b3251f81aceec5cde59d5cf326d281c489da24b"
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
      system_command "curl", args: ["-s", "-o", icon_path, "https://raw.githubusercontent.com/leejongyoung/homebrew-filezilla/main/FileZilla.icns"]
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
  