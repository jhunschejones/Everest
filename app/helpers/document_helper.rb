module DocumentHelper
  def truncate_action_text(rich_text:, paragraphs: 1)
    rich_text_paragraphs = Nokogiri::HTML::DocumentFragment
      .parse(rich_text.body.to_html)
      .children

    selected_paragraphs =
      if paragraphs > (rich_text_paragraphs.size - 1)
        rich_text_paragraphs
      else
        rich_text_paragraphs[0..paragraphs]
      end

    remove_basic_link_tags(selected_paragraphs.to_html)
  end

  def remove_basic_link_tags(html_string)
    html_string.gsub(/<a href=".+">/, "").gsub(/<\/a>/, "")
  end
end
