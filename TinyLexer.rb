#
#  Class Lexer - Reads a TINY program and emits tokens
#
class Lexer
# Constructor - Is passed a file to scan and outputs a token
#               each time nextToken() is invoked.
#   @c        - A one character lookahead 
	def initialize(filename)
		# Need to modify this code so that the program
		# doesn't abend if it can't open the file but rather
		# displays an informative message
		@f = File.open(filename,'r:utf-8') rescue nil
        if @f.nil?
            puts "File '#{filename}' wasn't found"
        end
		

		# Go ahead and read in the first character in the source
		# code file (if there is one) so that you can begin
		# lexing the source code file 
		if (! @f.eof?)
			@c = @f.getc()
		else
			@c = "eof"
			@f.close()
		end
	end
	
	# Method nextCh() returns the next character in the file
	def nextCh()
		if (! @f.eof?)
			@c = @f.getc()
		else
			@c = "eof"
		end
		
		return @c
	end

	# Method nextToken() reads characters in the file and returns
	# the next token
	def nextToken() 
		if @c == "eof"
			return Token.new(Token::EOF,"eof")
				
		elsif (whitespace?(@c))
			str =""
			while whitespace?(@c)
				str += @c
				nextCh()
			end
			tok = Token.new(Token::WS,str)
			return tok

        elsif (letter?(@c))
            str = ""
            while letter?(@c)
                str += @c
                nextCh()
            end
            
            case str
            when "print"
                tok = Token.new(Token::PRINT,str)
            else
                tok = Token.new(Token::ID,str)
            end
            return tok

        elsif (numeric?(@c))
            str = ""
            while numeric?(@c)
                str += @c
                nextCh()
            end
            tok = Token.new(Token::NUM,str)
            return tok

        elsif @c == '('
            str = @c
            nextCh()
            tok = Token.new(Token::LPAREN,str)
            return tok

        elsif @c == ')'
            str = @c
            nextCh()
            tok = Token.new(Token::RPAREN,str)
            return tok

        elsif @c == '+'
            str = @c
            nextCh()
            tok = Token.new(Token::ADDOP,str)
            return tok

        elsif @c == '-'
            str = @c
            nextCh()
            tok = Token.new(Token::SUBOP,str)
            return tok

        elsif @c == '/'
            str = @c
            nextCh()
            tok = Token.new(Token::DIVOP,str)
            return tok

        elsif @c == '*'
            str = @c
            nextCh()
            tok = Token.new(Token::MULTOP,str)
            return tok

        elsif @c == '='
            str = @c
            nextCh()
            if @c == '='
                str +=@c
                nextCh()
                tok = Token.new(Token::EQUALS,str)
            else
                tok = Token.new(Token::ASSIGN,str)
            end
            return tok

        elsif @c == ','
            str = @c
            nextCh()
            tok = Token.new(Token::COMMA,str)
            return tok
    
        elsif @c == '&'
            str = @c
            nextCh()
            tok = Token.new(Token::AND,str)
            return tok

        elsif @c == "<"
            str = @c
            nextCh()
            tok = Token.new(Token::LESSTHAN,str)
            return tok
                
        elsif @c == ">"
            str = @c
            nextCh()
            tok = Token.new(Token::GREATTHAN,str)
            return tok

        elsif @c == "!"
            str = @c
            nextCh()
            tok = Token.new(Token::EXCLAIM,str)
            return tok

        elsif @c == ";"
            str = @c
            nextCh()
            tok = Token.new(Token::SEMICOLON,str)
            return tok

        else
            str = @c
            nextCh()
            tok = Token.new(Token::UNKWN,str)
            return tok
        end
                

        # elsif ...
		# more code needed here! complete the code here 
		# so that your scanner can correctly recognize,
		# print (to a text file), and display all tokens
		# in our grammar that we found in the source code file
		
		# FYI: You don't HAVE to just stick to if statements
		# any type of selection statement "could" work. We just need
		# to be able to programatically identify tokens that we 
		# encounter in our source code file.
		
		# don't want to give back nil token!
		# remember to include some case to handle
		# unknown or unrecognized tokens.
		# below is an example of how you "could"
		# create an "unknown" token directly from 
		# this scanner. You could also choose to define
		# this "type" of token in your token class

	
end
end
#
# Helper methods for Scanner
#
def letter?(lookAhead)
	lookAhead =~ /^[a-z]|[A-Z]$/
end

def numeric?(lookAhead)
	lookAhead =~ /^(\d)+$/
end

def whitespace?(lookAhead)
	lookAhead =~ /^(\s)+$/
end
