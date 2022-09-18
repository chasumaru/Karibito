RSpec.describe 'StaticPages', type: :request do

  describe '#about' do
    it '正常にレスポンスを返すこと' do
      get about_path
      expect(response).to have_http_status :ok
    end
  end

  describe '#q&a' do
    it '正常にレスポンスを返すこと' do
      get faq_path
      expect(response).to have_http_status :ok
    end
  end

  describe '#privacy' do
    it '正常にレスポンスを返すこと' do
      get privacy_path
      expect(response).to have_http_status :ok
    end
  end

  describe '#term' do
    it '正常にレスポンスを返すこと' do
      get term_path
      expect(response).to have_http_status :ok
    end
  end

  describe '#index' do
    it '正常にレスポンスを返すこと' do
      get root_path
      expect(response).to have_http_status :ok
    end
  end
end