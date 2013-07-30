require 'rackatweet/config'

module Rackatweet

  describe Config do
    
    describe 'cache_expires_in' do
      
      it 'has a default of 3600' do
        Config.cache_expires_in.should == 3600
      end
      
      context 'it has been set to nil' do
        
        before do
          Config.cache_expires_in = nil
        end
        
        it 'should return the default value of 3600' do
          Config.cache_expires_in.should == 3600
        end
        
      end
      # it has been set to nil
      
    end
    # cache_expires_in
  
  
    describe 'timeout' do
      
      it 'has a default of 10' do
        Config.timeout.should == 10
      end
      
      context 'it has been set to nil' do
        
        before do
          Config.timeout = nil
        end
        
        it 'should return the default value of 10' do
          Config.timeout.should == 10
        end
        
      end
      # it has been set to nil
      
    end
    # timeout
  end
  
end