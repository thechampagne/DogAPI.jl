module DogAPI

using HTTP
using JSON

export randomimage, multiple_randomimages, randomimage_bybreed, multiple_randomimages_bybreed, imagesbybreed
export randomimage_bysubbreed, multiple_randomimages_bysubbreed, imagesbysubbreed, breedslist, subbreedslist

struct DogAPIException <: Exception
    msg
end

function _getrequest(endpoint::String)
    try
        request = HTTP.request("GET", "https://dog.ceo/api/$endpoint")
        response = String(request.body)
        return response
    catch ex
        if isa(ex, HTTP.ExceptionRequest.StatusError)
            return String(ex.response.body)
        else
            rethrow(ex)
        end
    end
end

"""
DISPLAY SINGLE RANDOM IMAGE FROM ALL DOGS COLLECTION

Returns a random dog image
"""
function randomimage()
    try
        response = _getrequest("breeds/image/random")
        json = JSON.parse(response)
        if json["status"] != "success"
           throw(DogAPIException(json["message"]))
        end
        return json["message"]
    catch ex
        if isa(ex, DogAPIException)
            rethrow(ex)
        else
            throw(DogAPIException(sprint(showerror, ex)))
        end
    end
end

"""
DISPLAY MULTIPLE RANDOM IMAGES FROM ALL DOGS COLLECTION

* `imagesNumber` number of images

*NOTE* ~ Max number returned is 50

Return multiple random dog image
"""
function multiple_randomimages(imagesNumber::Int)
    try
        response = _getrequest("breeds/image/random/$imagesNumber")
        json = JSON.parse(response)
        if json["status"] != "success"
           throw(DogAPIException(json["message"]))
        end
        return json["message"]
    catch ex
        if isa(ex, DogAPIException)
            rethrow(ex)
        else
            throw(DogAPIException(sprint(showerror, ex)))
        end
    end
end

"""
RANDOM IMAGE FROM A BREED COLLECTION

* `breed` breed name

Returns a random dog image from a breed, e.g. hound
"""
function randomimage_bybreed(breed::String)
    try
        response = _getrequest("breed/$(strip(breed))/images/random")
        json = JSON.parse(response)
        if json["status"] != "success"
           throw(DogAPIException(json["message"]))
        end
        return json["message"]
    catch ex
        if isa(ex, DogAPIException)
            rethrow(ex)
        else
            throw(DogAPIException(sprint(showerror, ex)))
        end
    end
end

"""
MULTIPLE IMAGES FROM A BREED COLLECTION

* `breed` breed name
* `imagesNumber` number of images

Return multiple random dog image from a breed, e.g. hound
"""
function multiple_randomimages_bybreed(breed::String, imagesNumber::Int)
    try
        response = _getrequest("breed/$(strip(breed))/images/random/$imagesNumber")
        json = JSON.parse(response)
        if json["status"] != "success"
           throw(DogAPIException(json["message"]))
        end
        return json["message"]
    catch ex
        if isa(ex, DogAPIException)
            rethrow(ex)
        else
            throw(DogAPIException(sprint(showerror, ex)))
        end
    end
end

"""
ALL IMAGES FROM A BREED COLLECTION

* `breed` breed name

Returns an array of all the images from a breed, e.g. hound
"""
function imagesbybreed(breed::String)
    try
        response = _getrequest("breed/$(strip(breed))/images")
        json = JSON.parse(response)
        if json["status"] != "success"
           throw(DogAPIException(json["message"]))
        end
        return json["message"]
    catch ex
        if isa(ex, DogAPIException)
            rethrow(ex)
        else
            throw(DogAPIException(sprint(showerror, ex)))
        end
    end
end

"""
SINGLE RANDOM IMAGE FROM A SUB BREED COLLECTION

* `breed` breed name
* `subBreed` sub_breed name

Returns a random dog image from a sub-breed, e.g. Afghan Hound
"""
function randomimage_bysubbreed(breed::String, subBreed::String)
    try
        response = _getrequest("breed/$(strip(breed))/$(strip(subBreed))/images/random")
        json = JSON.parse(response)
        if json["status"] != "success"
           throw(DogAPIException(json["message"]))
        end
        return json["message"]
    catch ex
        if isa(ex, DogAPIException)
            rethrow(ex)
        else
            throw(DogAPIException(sprint(showerror, ex)))
        end
    end
end

"""
MULTIPLE IMAGES FROM A SUB-BREED COLLECTION

* `breed` breed name
* `subBreed` sub_breed name
* `imagesNumber` number of images

Return multiple random dog images from a sub-breed, e.g. Afghan Hound
"""
function multiple_randomimages_bysubbreed(breed::String, subBreed::String, imagesNumber::Int)
    try
        response = _getrequest("breed/$(strip(breed))/$(strip(subBreed))/images/random/$imagesNumber")
        json = JSON.parse(response)
        if json["status"] != "success"
           throw(DogAPIException(json["message"]))
        end
        return json["message"]
    catch ex
        if isa(ex, DogAPIException)
            rethrow(ex)
        else
            throw(DogAPIException(sprint(showerror, ex)))
        end
    end
end

"""
LIST ALL SUB-BREED IMAGES

* `breed` breed name
* `subBreed` sub_breed name

Returns an array of all the images from the sub-breed
"""
function imagesbysubbreed(breed::String, subBreed::String)
    try
        response = _getrequest("breed/$(strip(breed))/$(strip(subBreed))/images")
        json = JSON.parse(response)
        if json["status"] != "success"
           throw(DogAPIException(json["message"]))
        end
        return json["message"]
    catch ex
        if isa(ex, DogAPIException)
            rethrow(ex)
        else
            throw(DogAPIException(sprint(showerror, ex)))
        end
    end
end

"""
LIST ALL BREEDS

Returns dictionary of all the breeds as keys and sub-breeds as values if it has
"""
function breedslist()
    try
        response = _getrequest("breeds/list/all")
        json = JSON.parse(response)
        if json["status"] != "success"
           throw(DogAPIException(json["message"]))
        end
        return json["message"]
    catch ex
        if isa(ex, DogAPIException)
            rethrow(ex)
        else
            throw(DogAPIException(sprint(showerror, ex)))
        end
    end
end

"""
LIST ALL SUB-BREEDS

* `breed` breed name

Returns an array of all the sub-breeds from a breed if it has sub-breeds
"""
function subbreedslist(breed::String)
    try
        response = _getrequest("breed/$(strip(breed))/list")
        json = JSON.parse(response)
        if json["status"] != "success"
           throw(DogAPIException(json["message"]))
        end
        if length(json["message"]) == 0
            throw(DogAPIException("the breed does not have sub-breeds"))
        end
        return json["message"]
    catch ex
        if isa(ex, DogAPIException)
            rethrow(ex)
        else
            throw(DogAPIException(sprint(showerror, ex)))
        end
    end
end

end
