require "rails_helper"

describe "CachingService " do
     before do
    CachingService.instance_variable_set(:@redis, nil)
  end
    # checking connection establishment and redis call
    it "creates and reuses the redis connection" do
       redis=instance_double(Redis)

       allow(Redis).to receive(:new).and_return(redis)

       expect(CachingService.redis).to eq(redis)
       expect(CachingService.redis).to eq(redis)
       expect(Redis).to have_received(:new).once
    end

  #   it"returns nil when the key does not exist" do
end
describe ".get" do
     before do
    CachingService.instance_variable_set(:@redis, nil)
  end
    it "returns parsed JSON when the key exists" do
    redis = instance_double(Redis)
    allow(Redis).to receive(:new).and_return(redis)
    allow(redis).to receive(:get)
        .with("products")
        .and_return('{"name":"laptop","price":1000}')

    result = CachingService.get("products")
    expect(result).to eq(
        "name" => "laptop",
        "price" => 1000
    )
    end
end

describe ".set" do
        before do
            CachingService.instance_variable_set(:@redis, nil)
        end
    it "sets the value in Redis with the specified expiry" do
        redis=instance_double(Redis)
        allow(Redis).to receive(:new).and_return(redis)
        allow(redis).to receive(:set)
            .with("products", '{"name":"laptop","price":1000}', ex: 1200)

        CachingService.set("products", { name: "laptop", price: 1000 }, 20.minutes)
        expect(redis).to have_received(:set)
            .with("products", '{"name":"laptop","price":1000}', ex: 1200)
    end
end

describe "delete" do
    before do
        CachingService.instance_variable_set(:@redis, nil)
    end
    it "deletes the key from Redis" do
        redis=instance_double(Redis)
        allow(Redis).to receive(:new).and_return(redis)
        allow(redis).to receive(:del).with("products")

        CachingService.delete("products")
        expect(redis).to have_received(:del).with("products")
    end
end
describe ".fetch" do
    before do
        CachingService.instance_variable_set(:@redis, nil)
    end
    it "returns cached value if it exists" do
        redis=instance_double(Redis)
        allow(Redis).to receive(:new).and_return(redis)
        allow(redis).to receive(:get).with("products").and_return('{"name":"laptop","price":1000}')

        result=CachingService.fetch("products") { { name: "phone", price: 500 } }
        expect(result).to eq(
            "name" => "laptop",
            "price" => 1000
        )
    end

    it "caches and returns the value if it does not exist" do
        redis=instance_double(Redis)
        allow(Redis).to receive(:new).and_return(redis)
        allow(redis).to receive(:get).with("products").and_return(nil)
        allow(redis).to receive(:set)

        result=CachingService.fetch("products") { { name: "phone", price: 500 } }
        expect(result).to eq(
            name: "phone",
            price: 500
        )
        expect(redis).to have_received(:set)
            .with("products", '{"name":"phone","price":500}', ex: 1200)
    end
end
