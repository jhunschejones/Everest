module AssetHelper
  def asset_exists?(path)
    return false unless path.present?
    if Rails.env.production?
      Rails.application.assets_manifest.find_sources(path) != nil
    else
      Rails.application.assets.find_asset(path) != nil
    end
  end
end
