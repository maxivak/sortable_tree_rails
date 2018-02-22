module SortableTreeHelper

  def render_sortable_tree(items, opts={})
    render :partial=>'sortable_tree/sortable_tree', locals: {items: items, options: opts}
  end


  def sortable_tree_render_nested_groups(groups, opts={})
    content_tag(:ol) do
      groups.map do |item, sub_groups|
        content_tag(:li, {id: "cat_#{item.id}"} ) do
          #(item.title +  sortable_tree_render_nested_groups(sub_groups, opts)).html_safe

          title = item.send(opts[:name_method] || :name) || ''

          s = content_tag(:div, {class: 'item'}) do
            (
                #'<div class="cell left"><i class="handle"></i></div>'\
                '<h3 class="cell left">'+title+'</h3>'\
              '<div class="cell right controls">'+sortable_tree_build_actions(item, opts)+'</div>'
            ).html_safe
          end
          (s + sortable_tree_render_nested_groups(sub_groups, opts)).html_safe
        end

      end.join.html_safe
    end
  end

  def sortable_tree_build_actions(item, opts={})
    partial = opts[:controls_partial] || nil
    if partial
      return render :partial=>partial, locals: {item: item, options: opts}
    else
      return ""
    end

  end

end