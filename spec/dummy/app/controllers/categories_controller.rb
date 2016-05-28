class CategoriesController < ApplicationController

  def index

  end

  include SortableTreeController::Sort
  sortable_tree 'Category', {parent_method: 'parent'}

  def manage
    # fix ancestry
    #Category.build_ancestry_from_parent_ids!

    #
    @items = Category.all.arrange(:order => :pos)

  end


end