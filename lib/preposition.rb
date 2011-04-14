# To change this template, choose Tools | Templates
# and open the template in the editor.

class Preposition
  def initialize
    
  end

  def and_table

  end

  def or_table

  end

  def if_table

  end

  def only_if_table

  end

  def tautologia?

  end

  def contradicao?

  end

  def factivel?

  end

  def calculo_prepo
    array = "( ~ p 1 ( t 2 ( ~ p 1 ~ p ) ) )" #( p 1 ( ~ t 2 ) )
    array2 = "( p 2 ( ( ~ p 1 q ) 3 ~ p ) )" #( ( 3 ~ p ) 2 p )
    array3 = "( ( p 1 ( r 3 ~ q ) ) 2 q )" # ( ( p 1 ) 2 q )
    array4 = "( ( r 3 q ) 3 w )" #( 3 w )
    array5 = "( w 3 ( r 3 q ) )" #( w 3 )
    array6 = "( r 1 ~ q )"
    array7 = "( ~ w 3 ( r 3 q ) )" #( ~ w 3 )
    array8 = "( ( r 3 q ) 3 ~ w )" #( 3 ~ w )

    $tab_token = array2.split
    count=0
    i=0
    aux_tab = Array.new
    aux_count=0
    aux_conec = Array.new(4)
    aux_conec_count=0
    teste = Array.new
    while count <= $tab_token.size
      if $tab_token[count] == ')'
        if $tab_token[count-2] =~ /[1-4]/ && $tab_token[count-4] == '(' && $tab_token[count-3] =~ /[a-zA-Z]/  #If com as duas letras positivas          
          teste = $tab_token.slice!(count-4..count)
          count-= teste.size
          aux_tab[aux_count] = teste
        elsif $tab_token[count-5] == '~' && $tab_token[count-3] =~ /[1-4]/  #If as duas letras são negativas
          teste = $tab_token.slice!(count-6..count)
          count-= teste.size
          aux_tab[aux_count] = teste
        elsif $tab_token[count-4] == '~' && $tab_token[count-2] =~ /[1-4]/  && $tab_token[count-3]=~ /[a-zA-Z]/ #If primeira letra negativa e segunda letra é positiva
          teste = $tab_token.slice!(count-5..count)
          count-= teste.size
          aux_tab[aux_count] = teste
        elsif $tab_token[count-5] == '(' && $tab_token[count-3] =~ /[1-4]/ && $tab_token[count-4]=~ /[a-zA-Z]/#If com segunda letra negativa e primeira positiva          
          teste = $tab_token.slice!(count-5..count)
          count-= teste.size
          aux_tab[aux_count] = teste
        elsif $tab_token[count-1] =~ /[1-4]/ && $tab_token[count-4] == '(' && $tab_token[count-3]=='~'#If letra negativa e operacao a direita
          aux_conec[aux_conec_count] =  $tab_token[count-1]
          teste = $tab_token.slice!(count-4..count)
          count-= teste.size
          teste = ['F','F','V','V']
          aux_tab[aux_count] = teste
          if aux_count==1
            troca = aux_tab[0]
            aux_tab[0] = aux_tab[1]
            aux_tab[1] = troca
          end
          #fazer troca
        elsif $tab_token[count-1] =~ /[1-4]/ && $tab_token[count-3] == '(' #If letra positiva e operacao a direita
          aux_conec[aux_conec_count] =  $tab_token[count-1]
          teste = $tab_token.slice!(count-3..count)
          count-= teste.size
          teste = ['V','V','F','F']
          aux_tab[aux_count] = teste
          if aux_count==1
            troca = aux_tab[0]
            aux_tab[0] = aux_tab[1]
            aux_tab[1] = troca
          end
        elsif $tab_token[count-1] =~ /[a-zA-Z]/ && $tab_token[count-3] == '(' #If letra positiva e operacao a esquerda          
          aux_conec[aux_conec_count] = $tab_token[count-2]
          teste = $tab_token.slice!(count-3..count)
          count-= teste.size
          teste = ['V','F','V','F']
          aux_tab[aux_count] = teste
        elsif $tab_token[count-1] =~ /[a-zA-Z]/ && $tab_token[count-4] == '('  && $tab_token[count-2]=='~' #If letra negativa e operacao a esquerda
          aux_conec[aux_conec_count] = $tab_token[count-3]
          teste = $tab_token.slice!(count-4..count)
          count-= teste.size
          teste = ['F','V','F','V']
          aux_tab[aux_count] = teste
        end
        count+=1
        aux_count+=1
        aux_conec_count+=1
      else
        count+=1
      end #end if (')')
    end #end while
    puts("AUX_TAB -> #{aux_tab}")
    puts("TABTOKEN -> #{$tab_token}")
    puts("AUX_CONEC -> #{aux_conec}")
  end
end
