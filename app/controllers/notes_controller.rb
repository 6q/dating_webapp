class NotesController < ApplicationController
	load_and_authorize_resource
	before_filter :set_anchor

	
	def create
		@note = Note.create(params[:note])
		redirect_to :back
	end

	def destroy
		@note = Note.find(params[:id])
		@note.destroy
		redirect_to :back
	end


	def set_anchor
		env["HTTP_REFERER"] += '#tab_notas'
	end
	private :set_anchor

end