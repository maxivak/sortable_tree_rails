# SortableTreeRails

GUI for sortable tree to manage data organized in tree with ancestry gem.

Works with Rails 5, Rails 4.


# Overview

The gem uses:
* [jquery-sortable plugin](https://johnny.github.io/jquery-sortable/) - jQuery Sortable UI
* [nestedSortable](https://github.com/ilikenwf/nestedSortable) - a jQuery plugin for nested lists which extends jQuery Sortable UI

# Demo
See demo app in the repository (spec/dummy).
Run page with the tree: `http://localhost:3000/categories/manage`.


# Usage



### Gemfile

```
gem 'haml-rails'

gem 'jquery-rails'
gem "jquery-ui-rails"

gem 'ancestry'
gem 'sortable_tree_rails'
```

* the gem uses HAML


### routes

```
# config/routes.rb

resources :categories do
  collection do
     post :sort
  end
end

```

This page (sort_categories_path) will be used by the gem to update data after drag&drop.

### model

It assumes that your model has already fields in DB for ancestry.

```
# app/models/category.rb

class Category < ActiveRecord::Base

  has_ancestry

  # it uses column ancestry_depth
  # has_ancestry :cache_depth=>true

end

```


### Javascript

Include js files in your assets file `application.js`:

```
//= require jquery2
//= require jquery-ui

//=require jquery.mjs.nestedSortable.js
//=require sortable_tree.js


```

it depends on jquery and jquery-ui which come from gems 'jquery-rails', 'jquery-ui-rails'.
Change `application.js` to include jquery and jquery-ui (jquery-ui/sortable) if you are not using these gems.
 



### CSS

Add CSS file to your styles.

for SCSS (app/assets/application.scss):

```
... your css here ..

@import "sortable_tree";


```


### controller

```
class CategoriesController < ApplicationController
  include SortableTreeController::Sort
  sortable_tree 'Category', {parent_method: 'parent'}

  def manage
    # get items to show in tree
    @items = Category.all.arrange(:order => :pos)

  end

end

```

### view

```
# app/views/categories/manage.html.haml

= render_sortable_tree(@items, {name_method: :name, sort_url: sort_categories_url, max_levels: 5, controls_partial: 'controls'})

```


```
# app/views/categories/_controls.html.haml

= link_to 'Edit', edit_category_url(item)
= link_to 'Delete', category_url(item), :method => :delete, :data => { :confirm => 'Are you sure?' }

```



# Customize

## Options

### Options for controller

in controller:
```

  include SortableTreeController::Sort
  sortable_tree 'ClassName', {_options_here_}

```


* ClassName - class name (camel case). For example, 'Category'.
* :sorting_attribute - attribute used for sorting. Set to nil to disable sorting.
* :parent_method - method used to access parent for the item. Set to nil to disable tree (not updating parent).

Examples.

* Example. For model with ancestry.
If you use ancestry in model - set :parent_method to 'parent'.

```
  include SortableTreeController::Sort
  sortable_tree 'ClassName', {parent_method: 'parent', sorting_attribute: 'pos'}
```

* Example. Do only sorting, without tree.

```
  include SortableTreeController::Sort
  sortable_tree 'ClassName', {sorting_attribute: 'pos', parent_method: nil}
```

* Example. No sorting, update only parent.

```
  include SortableTreeController::Sort
  sortable_tree 'ClassName', {sorting_attribute: nil, parent_method: 'parent'}
```



## Options for view

```
= render_sortable_tree(@items, {__options_here})
```

* :name_method - defined which model method (usually, a column name) will be used to show name (default: :name)
* :sort_url - URL used to update data after item is moved to a new position
* :max_levels - max levels to show in tree (default: 5)
* :controls_partial - specify what partial view to use to show control links for each item in a tree. Set to nil to not show controls.



* example.

```
= render_sortable_tree(@items, {name_method: :name, sort_url: sort_categories_url, max_levels: 5})
```


* example of partial view with controls.

* main view:
```
= render_sortable_tree(@items, {name_method: :name, sort_url: sort_categories_url, max_levels: 5, controls_partial: 'controls'})
```

* partial with controls. Use local variable `item` in the partial view.

`_controls.html.haml`:

```
= link_to 'Edit', edit_category_url(item)
= link_to 'Delete', category_url(item), :method => :delete, :data => { :confirm => 'Are you sure?' }

```


# Customize

## customize view

* edit file 'views/sortable/_sortable.html.haml' to access the whole layout





# How it works

read Wiki


# Similar gems

GUI for sortable tree with awesome_nested_set gem:
* https://github.com/the-teacher/the_sortable_tree
* https://github.com/winescout/the_sortable_tree


# Credits
* Some pieces of code was created by inspiration of gem [ActiveAdmin Sortable Tree](https://github.com/maxivak/activeadmin-sortable-tree/)


