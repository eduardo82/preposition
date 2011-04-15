# To change this template, choose Tools | Templates
# and open the template in the editor.

class Preposition
  def initialize
    puts("ENTRE COM A PREPOSICAO A SER PROCESSADA")
    prepo = STDIN.gets()
    prepo.chomp!    
    calculo_prepo(prepo)
  end

  def and_table(letra1, letra2)
    vector = Array.new
    if letra1 == false && letra2 == true
      vector = ['F','F','V','F']
    elsif letra1 == true && letra2 == false
      vector = ['F','V','F','V']
    elsif letra1 == false && letra2 == false
      vector = ['F','F','F','V']
    elsif letra1 == true && letra2 == true
      vector = ['F','F','F','F']
    end
    return vector
  end

  def or_table(letra1, letra2)
    vector = Array.new
    if letra1 == false && letra2 == true
      vector = ['V','F','V','V']
    elsif letra1 == true && letra2 == false
      vector = ['V','V','F','V']
    elsif letra1 == false && letra2 == false
      vector = ['F','V','V','V']
    elsif letra1 == true && letra2 == true
      vector = ['V','V','V','F']
    end
    return vector
  end

  def if_table(letra1, letra2)
    vector = Array.new
    if letra1 == false && letra2 == true
      vector = ['V','V','V','F']
    elsif letra1 == true && letra2 == false
      vector = ['F','V','V','V']
    elsif letra1 == false && letra2 == false
      vector = ['V','V','F','V']
    elsif letra1 == true && letra2 == true
      vector = ['V','F','V','V']
    end
    return vector
  end

  def only_if_table(letra1, letra2)
    vector = Array.new
    if letra1 == false && letra2 == true
      vector = ['F','V','V','F']
    elsif letra1 == true && letra2 == false
      vector = ['F','V','V','F']
    elsif letra1 == false && letra2 == false
      vector = ['V','F','F','V']
    elsif letra1 == true && letra2 == true
      vector = ['V','F','F','V']
    end    
    return vector
  end

  def tautologia?(vector)
    aux = 0
    for i in vector      
      if i == 'V'
        aux+=1
      end
    end
    if aux==4
      return true
    else
      return false
    end

  end

  def contradicao?(vector)
    aux = 0
    for i in vector      
      if i == 'F'
        aux+=1
      end
    end
    if aux==4
      return true
    else
      return false
    end
  end

  def factivel?(vector)
    aux = 0
    for i in vector
      if i == 'V'
        aux+=1
      end
    end
    if aux>=1 && aux < 4
      return true
    else
      return false
    end
  end

  def calculo_prepo(preposicao)
    array = "( ~ p 1 ( t 2 ( ~ p 1 ~ p ) ) )" #( p 1 ( ~ t 2 ) )
    array2 = "( p 2 ( ( ~ p 1 q ) 3 ~ p ) )" #( ( 3 ~ p ) 2 p )
    array3 = "( ( p 3 ( r 3 ~ q ) ) 3 q )" # ( ( p 1 ) 2 q )
    array4 = "( ( r 2 q ) 1 ~ w )" #( 3 w )
    array5 = "( w 3 ( r 3 q ) )" #( w 3 )
    array6 = "( ( r 1 ~ q ) 2 p )"
    array7 = "( ~ w 3 ( r 3 q ) )" #( ~ w 3 )
    array8 = "( ( r 3 q ) 3 ~ w )" #( 3 ~ w )

    $tab_token = preposicao.split
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
          aux_tab[aux_count] = calc_one_prepo(teste)
        elsif $tab_token[count-5] == '~' && $tab_token[count-3] =~ /[1-4]/  #If as duas letras são negativas
          teste = $tab_token.slice!(count-6..count)
          count-= teste.size
          aux_tab[aux_count] = calc_one_prepo(teste)
        elsif $tab_token[count-4] == '~' && $tab_token[count-2] =~ /[1-4]/  && $tab_token[count-3]=~ /[a-zA-Z]/ #If primeira letra negativa e segunda letra é positiva
          teste = $tab_token.slice!(count-5..count)
          count-= teste.size
          aux_tab[aux_count] = calc_one_prepo(teste)
        elsif $tab_token[count-5] == '(' && $tab_token[count-3] =~ /[1-4]/ && $tab_token[count-4]=~ /[a-zA-Z]/#If com segunda letra negativa e primeira positiva          
          teste = $tab_token.slice!(count-5..count)
          count-= teste.size
          aux_tab[aux_count] = calc_one_prepo(teste)
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
    aux_conec.compact!
    until aux_tab.length == 1
      aux_tab[0] = calc_table_table(aux_tab[0], aux_tab[1], aux_conec[0])      
      aux_tab.slice!(1)
      aux_conec.slice!(0)      
    end
    puts("TABELA FINAL -> #{aux_tab}")
    if tautologia?(aux_tab[0])
      puts("TAUTOLOGIA")
    elsif contradicao?(aux_tab[0])
      puts("CONTRADICAO")
    elsif factivel?(aux_tab[0])
      puts("FACTIVEL")
    end
  end

  def calc_one_prepo(prepos)
    vector = Array.new
    conectivo = nil
    if prepos.length == 7      
      conectivo = prepos[3]
      letra1 = false
      letra2 = false
      if (conectivo == '1')   
        vector = and_table(letra1, letra2)
      elsif (conectivo == '2')
        vector = or_table(letra1, letra2)        
      elsif (conectivo == '3')
        vector = if_table(letra1, letra2)
      elsif (conectivo == '4')
        vector = only_if_table(letra1, letra2)
      end
    elsif prepos.length == 5      
      conectivo = prepos[2]
      letra1 = true
      letra2 = true
      if (conectivo == '1')
        vector = and_table(letra1, letra2)
      elsif (conectivo == '2')
        vector = or_table(letra1, letra2)
      elsif (conectivo == '3')
        vector = if_table(letra1, letra2)
      elsif (conectivo == '4')
        vector = only_if_table(letra1, letra2)
      end
    elsif prepos.length == 6      
      if (prepos[1] == "~")        
        conectivo = prepos[3]
        letra1 = false
        letra2 = true
        if (conectivo == '1')
          vector =   and_table(letra1, letra2)
        elsif (conectivo == '2')
          vector =   or_table(letra1, letra2)
        elsif (conectivo == '3')
          vector =   if_table(letra1, letra2)
        elsif (conectivo == '4')
          vector =   only_if_table(letra1, letra2)
        end
      else        
        conectivo = prepos[2]
        letra1 = true
        letra2 = false
        if (conectivo == '1')
          vector =   and_table(letra1, letra2)
        elsif (conectivo == '2')
          vector =   or_table(letra1, letra2)
        elsif (conectivo == '3')
          vector =   if_table(letra1, letra2)
        elsif (conectivo == '4')
          vector =   only_if_table(letra1, letra2)
        end
      end
    end
    return vector
  end

  def calc_table_table(vector1, vector2, conectivo)
    aux_vector = Array.new    
    if conectivo == '1'
      for aux_count in (0..3) do
        if vector1[aux_count] == 'F' || vector2[aux_count] == 'F'
          aux_vector[aux_count] = 'F'
        else
          aux_vector[aux_count] = 'V'
        end
      end
    elsif conectivo == '2'
      for aux_count1 in (0..3) do
        if vector1[aux_count1] == 'V' || vector2[aux_count1] == 'V'
          aux_vector[aux_count1] = 'V'
        else
          aux_vector[aux_count1] = 'F'
        end
      end
    elsif conectivo == '3'
      for aux_count2 in (0..3) do
        if vector1[aux_count2] == 'V' && vector2[aux_count2] == 'V'
          aux_vector[aux_count2] = 'V'
        elsif vector1[aux_count2] == 'F' && vector2[aux_count2] == 'F'
          aux_vector[aux_count2] = 'V'
        elsif vector1[aux_count2] == 'V' && vector2[aux_count2] == 'F'
          aux_vector[aux_count2] = 'F'
        elsif vector1[aux_count2] == 'F' && vector2[aux_count2] == 'V'
          aux_vector[aux_count2] = 'V'
        end
      end
    elsif conectivo == '4'
      for aux_count3 in (0..3) do
        if vector1[aux_count3] == 'V' && vector2[aux_count3] == 'V'
          aux_vector[aux_count3] = 'V'
        elsif vector1[aux_count3] == 'F' && vector2[aux_count3] == 'F'
          aux_vector[aux_count3] = 'V'
        elsif vector1[aux_count3] == 'F' || vector2[aux_count3] == 'F'
          aux_vector[aux_count3] = 'F'
        end
      end
    end    
    return aux_vector
  end
end