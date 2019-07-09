module ApplicationHelper
  def gravatar_for(user, options = { size:80 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "http://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.chefname, class: "img-circle")
  end

  def chef_has_recipes?(chef)
    chef.recipes.any? ? chef.recipes.length.to_s + " recipes" : "No recipes yet"
  end

  def get_last_recipe_link(chef)
    link_to "Latest Recipe: " + chef.recipes.last.name, recipe_path(chef.recipes.last) if chef.recipes.any?
  end
end
