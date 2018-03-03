class ArticlesController < ApplicationController
	http_basic_authenticate_with name: 'admin', password: 'admin', except: [:index, :show]
	before_action :provide_article, only: [:show, :destroy, :edit, :update]

	def index #lista artykułów
		@articles = Article.all
	end

	def new
		@article=Article.new
	end
	
	def create
		# render plain: params[:article].inspect # wyświetla parametry
		@article = Article.new(article_params)
		if @article.save
			redirect_to article_path(@article) #odnosi się do id obiektu
		else
			render 'new' # jeśli są niesprełnione warunki walidacji nie przepuści nas dalej ale zostawi wypełnione dane w formuarzu
		end
	end

	def show #nie trzeba wywoływać metody provide_article, bo ją wykonaliśmy na początku klasy
		@comment = Comment.new
	end

	def edit	
	end

	def update
		article_params
		if @article.update(article_params)
			redirect_to articles_path
		else
			render 'edit' # jeśli są niesprełnione warunki walidacji nie przepuści nas dalej ale zostawi wypełnione dane w formuarzu
		end	
	end
	
	def destroy
		@article.destroy
		redirect_to articles_path #przekieroanie do wszystkich artykułów
	end

	private

	def article_params
		params.require(:article).permit(:title, :text) #ważne. 
	end

	def provide_article
		@article=Article.find(params[:id])	
	end


end