module Refinery
  module Portfolio
    module Admin
      class ItemsController < ::Refinery::AdminController
        include Refinery::Portfolio

        crudify :'refinery/portfolio/item',
                :order => 'lft ASC',
                :xhr_paging => true

        before_filter :find_gallery, :only => [:index]

        def index
          if params[:orphaned]
            @items = Item.orphaned
          elsif params[:gallery_id]
            @items = @gallery.items 
          else
            redirect_to refinery.portfolio_admin_galleries_path and return
          end

          @items = @items.page(params[:page])
        end

        def new
          @item = Item.new(params.except(:controller, :action, :switch_locale))
        end

        private
        def find_gallery
          @gallery = Gallery.find(params[:gallery_id]) if params[:gallery_id]
        end

      end
    end
  end
end