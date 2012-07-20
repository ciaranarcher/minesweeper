require 'mine_sweeper'

module MineSweeper
  describe MineSweeper do
    describe MineField do
      before(:each) do
        @mine_field = MineField.new
      end

      it 'has a rows value that can be set' do
        @mine_field.rows = 5
      end

      it 'has a cols value that can be set' do
        @mine_field.cols = 5
      end

      describe '#valid?' do
        it 'fails if there is no rows value and cols value' do
          @mine_field.valid?.should == false
        end

        it 'fails if there is no rows value' do
          @mine_field.cols = 5
          @mine_field.valid?.should == false
        end

        it 'fails if there is no cols value' do
          @mine_field.rows = 5
          @mine_field.valid?.should == false
        end

        it 'fails if rows value is not in range' do
          @mine_field.rows = 101
          @mine_field.cols = 5
          @mine_field.valid?.should == false

          @mine_field.rows = -1
          @mine_field.cols = 5
          @mine_field.valid?.should == false
        end

        it 'fails if cols value is not in range' do
          @mine_field.rows = 5
          @mine_field.cols = 101
          @mine_field.valid?.should == false

          @mine_field.rows = 5
          @mine_field.cols = -1
          @mine_field.valid?.should == false
        end

        it 'fails if rows value and cols value are not in range' do
          @mine_field.rows = -1
          @mine_field.cols = -1
          @mine_field.valid?.should == false
        end

        it 'succeeds if rows value and cols value are in range' do
          @mine_field.rows = 1
          @mine_field.cols = 100
          @mine_field.valid?.should == true

          @mine_field.rows = 100
          @mine_field.cols = 1
          @mine_field.valid?.should == true

          # Zero rows value and cols value are allowed
          @mine_field.rows = 0
          @mine_field.cols = 0
          @mine_field.valid?.should == true
        end
      end

      describe '#append_row for square grid' do
        before(:each) do
          @mine_field.rows = 5
          @mine_field.cols = 5
        end

        it 'takes a string of characters' do
          @mine_field.append_row '.....'
        end

        it 'each char must be a "." or a "*"' do
          @mine_field.append_row('.....').should == true
          @mine_field.append_row('*.*..').should == true
          @mine_field.append_row('*****').should == true
          @mine_field.append_row('F****').should == false
          @mine_field.append_row('F*.*8').should == false
        end

        it 'each string must be of correct length' do
          @mine_field.append_row('.....').should == true
          @mine_field.append_row('......').should == false
          @mine_field.append_row('....').should == false
        end

        it 'can only append a certain number of rows' do
          @mine_field.append_row('.....')
          @mine_field.append_row('.....')
          @mine_field.append_row('.....')
          @mine_field.append_row('.....')
          @mine_field.append_row('.....')
          
          expect { @mine_field.append_row('.....') }.to raise_error('Too many rows!')

          @mine_field.field.length.should == 5
        end
      end

      describe '#append_row for rectangular grid' do
        before(:each) do
          @mine_field.rows = 3
          @mine_field.cols = 5
        end

        it 'takes a string of characters' do
          @mine_field.append_row '.....'
        end

        it 'each char must be a "." or a "*"' do
          @mine_field.append_row('**...').should == true
          @mine_field.append_row('.....').should == true
          @mine_field.append_row('.*...').should == true
        end

        it 'each string must be of correct length' do
          @mine_field.append_row('.....').should == true
          @mine_field.append_row('......').should == false
          @mine_field.append_row('....').should == false
        end

        it 'can only append a certain number of rows' do
          @mine_field.append_row('.....')
          @mine_field.append_row('.....')
          @mine_field.append_row('.....')
          
          expect { @mine_field.append_row('.....') }.to raise_error('Too many rows!')

          @mine_field.field.length.should == 3
        end
      end

      describe '#score_position' do
        before(:each) do
          @mine_field.rows = 4
          @mine_field.cols = 4
          @mine_field.append_row('*...')
          @mine_field.append_row('....')
          @mine_field.append_row('.*..')
          @mine_field.append_row('...*')
        end

        it 'returns the correct score for a particular position' do
          @mine_field.score_position(0, 0).should eq '*'
          @mine_field.score_position(0, 1).should eq 1
          @mine_field.score_position(1, 1).should eq 2
          @mine_field.score_position(2, 1).should eq '*'
          @mine_field.score_position(3, 3).should eq '*'
          @mine_field.score_position(3, 0).should eq 1
          @mine_field.score_position(0, 3).should eq 0
        end

      end

      describe '#score' do
        before(:each) do
          @mine_field.rows = 4
          @mine_field.cols = 4
          @mine_field.append_row('*...')
          @mine_field.append_row('....')
          @mine_field.append_row('.*..')
          @mine_field.append_row('....')
        end

        it 'should match expected output' do
          scored_field = @mine_field.score
          scored_field.flatten.should == ['*',1,0,0, 2,2,1,0, 1,'*',1,0, 1,1,1,0]
        end

        it 'should be printable' do
          @mine_field.score
          @mine_field.print_field_scored.should == "*100\n2210\n1*10\n1110\n"
        end
      end
    end
  end
end