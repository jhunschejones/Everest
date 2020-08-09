User.all.each do |user|
  img = Avatarly.generate_avatar(
    user.name,
    opts={
      background_color: "#910bfe",
      font_color: "#FFF",
      size: 256,
      font: Rails.root.join("app/assets/fonts/Roboto/Roboto-Bold.ttf").to_s
    }
  )
  File.open(Rails.root.join("public/images/#{user.initials}-avatar.png"), "wb") do |f|
    f.write(img)
  end
end
