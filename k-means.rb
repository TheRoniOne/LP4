require 'csv', 'math'

class Centroide
    attr_accessor :posX,:posY

    def initialize()
        @posX = 0
        @posY = 0
    end

    def mover(sum,cont)
        @posX = sum[0] / cont
        @posY = sum[1] / cont
    end
end

class Nodo
    attr_accessor :cluster

    def initialize()
        @sepal_length = 0
        @sepal_width = 0
        @petal_length = 0
        @petal_width = 0
        @species = ''
        @cluster = nil
    end

    def calcCentCercano(arrayCentroides)
        #calcula la distacia entre tu posicion y la de los 3 centroides
        menorDist = Integer.sqrt(((@sepal_length - arrayCentroides[0].x)**2) + ((@sepal_width - arrayCentroides[0].y))**2)
        cluster = 0

        for i in 1..2
            dist = Integer.sqrt(((@sepal_length - arrayCentroides[i].x)**2) + ((@sepal_width - arrayCentroides[i].y))**2)
            
            if dist < menorDist
                menorDist = dist
                cluster = i
            end
        end

        @cluster = cluster
    end

end

class AlmacenCentroides < Centroide
    attr_accessor :arrayCentroides

    def initialize
        arrayCentroides = Array.new(3)
    end

    def generarCentroides
      for i in 0..2 #mejorar el random
        centroide = Centroide.new()
        rnd = Random.new
        centroide.posX = rnd.rand(15)
        centroide.posY = rnd.rand(15)
        arrayCentroides.push(centroide)
      end
    end
end

class Almacen
    def initialize()
        arrayNodos = Array.new()
    end

    def generar()
        CSV.foreach("path/to/file.csv") do |row|
            nodo = Nodo.new()
            nodo.sepal_length = row[0]
            nodo.sepal_width = row[1]
            nodo.petal_length = row[2]
            nodo.petal_width = row[3]
            nodo.species = row[4]
            arrayNodos.push(nodo)
        end
    end

    def calcDistancias(arrayCentroides) #ponerle un mejor nombre a la funcion
        sum1 = Array.new(2)
        sum2 = Array.new(2)
        sum3 = Array.new(2)

        cont1 = 0
        cont2 = 0
        cont3 = 0

        #llama a calcCentCercano de cada nodo
        arrayNodos.each do |i|
            i.calcCentCercano(arrayCentroides)
            if i.cluster == 0
                sum1[0] += i.sepal_length
                sum1[1] += i.sepal_width
                cont1 +=1
            elsif i.cluster == 1
                sum2[0] += i.sepal_length
                sum2[1] += i.sepal_width
                cont2 +=1
            else
                sum3[0] += i.sepal_length
                sum3[1] += i.sepal_width
                cont3 +=1
            end
        end

        #llamar a la funcion mover de los centroides
        if cont1 > 0
            centroide1.mover()
        if cont2 > 0
            centroide2.mover()
        if cont3 > 0
            centroide3.mover()
        
    end
end

def main()
    almacen = Almacen.new
    almacen.generar

    contIt = 0

    almacenCentroides = AlmacenCentroides.new
    almacenCentroides.generarCentroides

    while (almacenCentroides[i].posX == posAntX and #haz bucle hasta que todo centroide deje de moverse
        almacen.calcDistancias(almacenCentroides.arrayCentroides)
        contIt +=1
    end
    
    puts "Proceso terminado luego de #{contIt.to_s} iteraciones."
end

if __FILE__ == $0
    main()
end
