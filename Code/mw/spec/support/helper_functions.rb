def response_body
  JSON.parse(response.body)
end

def accept_json
	request.headers['accept'] = 'application/json'
end

def model_serialize(resource, options=[])
	ActiveModelSerializers::SerializableResource.new(
    resource,
    {
      include: options
    }
  ).as_json
end
