require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Saxophone global configurations" do
  before(:all) do
    class A
      include Saxophone
    end
  end

  after(:all) do
    Object.send(:remove_const, :A)
  end

  describe "handler config" do
    after(:all) do
      Saxophone.handler = :ox # restore default settings
    end

    context "with handler not set" do
      it "uses ox as handler" do
        expect(Saxophone.handler).to eq :ox
      end
    end

    context "with handler set to ox" do
      before do
        Saxophone.handler = :ox
      end

      it "uses ox as handler" do
        expect(Saxophone.handler).to eq :ox
      end
    end

    context "with handler set to oga" do
      before do
        Saxophone.handler = :oga
      end

      it "uses oga as handler" do
        expect(Saxophone.handler).to eq :oga
      end
    end

    context "with handler set to nokogiri" do
      before do
        Saxophone.handler = :nokogiri
      end

      it "uses nokogiri as handler" do
        expect(Saxophone.handler).to eq :nokogiri
      end
    end

    context "with handler set to some other value" do
      it "raises error" do
        expect { Saxophone.handler = :not_a_valid_handler }.to raise_error(LoadError)
      end
    end
  end

  describe "global on_error config" do
    broken_xml = "<top><title>Te & st</title><b>Matched!</b><c>And Again</c></top>"
    xml = "<top><title>Test</title><b>Matched!</b><c>And Again</c></top>"

    context "not configured" do
      it "does not raise exception on valid xml" do
        expect { A.parse xml }.not_to raise_error
      end

      it "does not raise exception on broken xml" do
        expect { A.parse broken_xml }.not_to raise_error
      end
    end

    context "configured to raise exception" do
      before(:all) do
        Saxophone.on_error = ->(error_string) { raise error_string }
      end

      after(:all) do
        Saxophone.on_error = ->(_) {} # restore default settings
      end

      it "does not raise exception on valid xml" do
        expect { A.parse xml }.not_to raise_error
      end

      it "raises exception on broken xml" do
        expect { A.parse broken_xml }.to raise_error(RuntimeError)
      end
    end
  end
end
