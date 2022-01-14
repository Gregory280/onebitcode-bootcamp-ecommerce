shared_examples "pagination meta attributes" do |pagination_attributes| 

  it "returns :meta attributes with right pagination data" do
    pagination_attributes.stringify_keys!
    expect(body_json['meta']).to include(pagination_attributes)
  end

end