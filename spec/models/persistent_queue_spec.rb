require 'rails_helper'


describe PersistentQueue do
  let(:test_default) {'test_queue'}
  before do
    stub_const("PersistentQueue::DEFAULT_NAME", test_default)
  end

  it "has default queue name with no parameters" do
    subject { PersistentQueue.new }
    expect(subject.name).to eq(test_default)
  end

  it "enqueues and dequeues to default queue from class methods" do
    PersistentQueue.enqueue(1)
    expect(PersistentQueue.dequeue).to eq(1)
  end

  it "enqueues and dequeues to named queue from class methods" do
    PersistentQueue.enqueue(5, name:'other_test_queue')
    expect(PersistentQueue.dequeue(name:'other_test_queue')).to eq(5)
  end

  it "uses a single queue on queue instances" do
    queue = PersistentQueue.new(name:'third_test_queue')
    color1 = Color.new(red:5, green:5, blue:5)
    color2 = Color.new(red:10, green:5, blue:0)
    PersistentQueue << color2
    queue << color1
    expect(queue.dequeue).to eq(color1)
    PersistentQueue.dequeue # real redis so don't leave stuff there
  end

  it "returns enqueued items in FIFO order" do
    color1 = Color.new(red:5, green:5, blue:5)
    color2 = Color.new(red:10, green:5, blue:0)
    PersistentQueue << color1
    PersistentQueue << color2
    expect(PersistentQueue.dequeue).to eq(color1)
    expect(PersistentQueue.dequeue).to eq(color2)
  end
end