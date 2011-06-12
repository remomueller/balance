module WillPaginate
  class LinkRenderer
    def page_link_or_span(page, span_class, text = nil, update = nil, method = :get)
      text ||= page.to_s
      classnames = Array[*span_class]

      if page and page != current_page
        if update
          @template.link_to text, url_for(page), :remote => true, :method => method, :update => update, :before => 'showLoading()', :complete => 'hideLoading()', :class => classnames[1]
        else
          @template.link_to text, url_for(page), :rel => rel_value(page), :class => classnames[1]
        end
      else
        @template.content_tag :span, text, :class => classnames.join(' ')
      end
    end

    def to_html
      links = @options[:page_links] ? windowed_links : []

      links.unshift page_link_or_span(@collection.previous_page, %w(disabled prev_page), @options[:prev_label], @options[:update])
      links.push    page_link_or_span(@collection.next_page,     %w(disabled next_page), @options[:next_label], @options[:update])

      html = links.join(@options[:separator])
      @options[:container] ? @template.content_tag(:div, html, html_attributes) : html
    end
    
    def windowed_links
      prev = nil

      visible_page_numbers.inject [] do |links, n|
        # detect gaps:
        links << gap_marker if prev and n > prev + 1
        links << page_link_or_span(n, 'current', nil, @options[:update])
        prev = n
        links
      end
    end
  end
end