describe EnumeratedConstants do
  # A test enumeration
  module Enumeraptor
    extend EnumeratedConstants

    EYES  = 2
    CLAWS = 6
    TEETH = 'lots'
    SPEED = 'faster than you'

    POINTY_PARTS = [CLAWS, TEETH]
  end

  describe '#all' do
    subject { Enumeraptor.all }

    it 'includes all constants' do
      expect(subject).to eq([2, 6, 'lots', 'faster than you'])
    end

    it 'does not include groups' do
      expect(subject).to_not include(Enumeraptor::POINTY_PARTS)
    end

    it 'is frozen' do
      expect(subject).to be_frozen
    end

    it 'is memoized' do
      all = Enumeraptor.all
      expect(Enumeraptor.instance_variable_get('@all')).to be(all)
    end
  end

  describe '#except' do
    it 'response to nonsense with everything' do
      expect(Enumeraptor.except(:ham)).to eq(Enumeraptor.all)
    end

    it 'includes everything but the argument' do
      expect(Enumeraptor.except(:eyes))
        .to eq(Enumeraptor.all - [Enumeraptor::EYES])
    end

    context 'with 2 arguments' do
      it 'includes everything but the arguments' do
        expect(Enumeraptor.except(:eyes, :claws))
          .to eq(Enumeraptor.all - [Enumeraptor::EYES, Enumeraptor::CLAWS])
      end
    end
  end

  describe '#sample' do
    it 'returns one of the constants' do
      expect(Enumeraptor.all).to include(Enumeraptor.sample)
    end

    it 'returns many of the constants' do
      Enumeraptor.sample(10).each do |sample|
        expect(Enumeraptor.all).to include(sample)
      end
    end

    it 'returns different ones' do
      samples = Array.new(100) { Enumeraptor.sample }
      expect(samples.uniq.length > 1).to be(true) # Almost certainly
    end
  end
end
