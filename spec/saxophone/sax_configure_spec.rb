require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Saxophone configure" do
  before do
    class A
      Saxophone.configure(A) do |c|
        c.element :title_new
      end
    end

    class B < A
      Saxophone.configure(B) do |c|
        c.element :b
      end
    end

    class C < B
      Saxophone.configure(C) do |c|
        c.element :c
      end
    end

    xml = "<top><title-new>Test</title-new><b>Matched!</b><c>And Again</c></top>"
    @a = A.parse xml
    @b = B.parse xml
    @c = C.parse xml
  end

  after do
    Object.send(:remove_const, :A)
    Object.send(:remove_const, :B)
    Object.send(:remove_const, :C)
  end

  it { expect(@a).to be_a(A) }
  it { expect(@a).not_to be_a(B) }
  it { expect(@a).to be_a(Saxophone) }
  it { expect(@a.title_new).to eq("Test") }
  it { expect(@b).to be_a(A) }
  it { expect(@b).to be_a(B) }
  it { expect(@b).to be_a(Saxophone) }
  it { expect(@b.title_new).to eq("Test") }
  it { expect(@b.b).to eq("Matched!") }
  it { expect(@c).to be_a(A) }
  it { expect(@c).to be_a(B) }
  it { expect(@c).to be_a(C) }
  it { expect(@c).to be_a(Saxophone) }
  it { expect(@c.title_new).to eq("Test") }
  it { expect(@c.b).to eq("Matched!") }
  it { expect(@c.c).to eq("And Again") }
end
