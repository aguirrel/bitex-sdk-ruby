require 'spec_helper'

describe Bitex::Resources::Compliance::Attachment do
  describe '.create', vcr: { cassette_name: 'compliance/attachments/create' } do
    subject(:attachment) do
      client.attachments.create(
        602,
        document: base64_enconded_file,
        document_file_name: 'id_front.jpg',
        document_content_type: 'image/jpeg',
        document_file_size: 106129,
        seed: identification_seed
      )
    end

    let(:identification_seed) { client.identification_seeds.new(id: '2707') }
    let(:base64_enconded_file) do
      image_file = File.open('spec/fixtures/compliance/attachments/image.jpg')
      "data:image/jpg\;base64,#{Base64.strict_encode64(image_file.read)}"
    end

    it { is_expected.to be_a(Bitex::Resources::Compliance::Attachment) }

    its(:'attributes.keys') do
      is_expected.to contain_exactly(
        *%w[type document document_file_name document_content_type document_file_size id created_at updated_at]
      )
    end

    its(:id) { is_expected.to be_present }
    its(:type) { is_expected.to eq('attachments') }

    its(:document_file_name) { is_expected.to eq('id_front.jpg') }
    its(:document_content_type) { is_expected.to eq('image/jpeg') }
    its(:document_file_size) { is_expected.to eq(106129) }

    its(:created_at) { is_expected.to be_present }
    its(:updated_at) { is_expected.to be_present }

    context 'about attached seed' do
      subject(:attached_seed) { attachment.relationships.attached_to_seed[:data] }

      its([:id]) { is_expected.to eq(identification_seed.id) }
      its([:type]) { is_expected.to eq(identification_seed.type) }
    end
  end
end
