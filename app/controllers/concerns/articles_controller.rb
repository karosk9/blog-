class ArticlesController < ApplicationController
	before_action :provide_article, only: [:show, :destroy, :edit, :update, :add_like]

	def index #lista artykułów
		if params[:q].present?
			@articles = Article.where("? = any(tag)", params[:q])
		else
			@articles = Article.all
		end
	end

	def new
		@article=Article.new
	end

	def create
		# render plain: params[:article].inspect # wyświetla parametry
		@article = Article.new(article_params)
		if @article.save
			redirect_to article_path(@article), notice: 'article created!' #odnosi się do id obiektu
		else
			render 'new' # jeśli są niesprełnione warunki walidacji nie przepuści nas dalej ale zostawi wypełnione dane w formuarzu
		end
	end

	def show #nie trzeba wywoływać metody provide_article, bo ją wykonaliśmy na początku klasy
		@comment = Comment.new(commenter: session[:commenter])
		@user_like = @article.likes.find_by(user: current_user)
		# @comment.commenter = session[:commenter]
	end

	def edit
			redirect_to articles_path if current_user != @article.user
	end

	def update
		article_params
		if @article.update(article_params)
			redirect_to articles_path
		else
			render 'edit' # jeśli są niesprełnione warunki walidacji nie przepuści nas dalej ale zostawi wypełnione dane w formuarzu
		end
	end

	def add_like
		if  @user_like.nil?
			@article.likes.create(user: current_user)
			redirect_to article_path(@article)
		end
	end

	def destroy
		@article.destroy
		redirect_to articles_path #przekieroanie do wszystkich artykułów
	end

	private

	def article_params
		params.require(:article).permit(:title, :text, :tag).merge(user: current_user) #ważne.
	end

	def provide_article
		@article=Article.find(params[:id])
	end


end
