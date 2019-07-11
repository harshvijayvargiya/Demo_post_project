class MultiplepostsController < InheritedResources::Base
  # before_action :set_posts,only: [:show, :edit, :update, :destroy]
  private

    def multiplepost_params
      params.require(:multiplepost).permit(:attchment, :article, tasks_attributes:[:attchment, :article])
    end

end
