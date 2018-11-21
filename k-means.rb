require 'csv'

class Centroide
    attr_accessor :posX,:posY

    def initialize()
        @posX = 0
        @posY = 0
    end

    def mover
        #todo
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

    def calcCentCercano
        #calcula la distacia entre tu posicion y la de los 3 centroides
        menorDist = nil
        cluster = nil

        for i in 0..2
            #arreglar calculo de distancia
            arrayCentroides[i].x
            arrayCentroides[i].y

            if dist < menorDist
                menorDist = dist
                cluster = i
            end
        end

        @cluster = cluster

        return menorDist
    end

end

class AlmacenCentroides < Centroide
    def initialize
        arrayCentroides = Array.new(3)
    end

    def generarCentroides
      for i in 0..2 #mejorar el random
        centroide = Centroide.new()
        rnd = Random.new
        centroide.posX = rnd.rand(100)
        centroide.posY = rnd.rand(100)
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

    def calcDistancias() #ponerle un mejor nombre
        sum1 = 0
        sum2 = 0
        sum3 = 0

        cont1 = 0
        cont2 = 0
        cont3 = 0

        #llama a calcCentCercano de cada nodo
        arrayNodos.each do |i|
            aux = i.calcCentCercano()
            if i.cluster == 0
                sum1 += aux
                cont1 +=1
            elsif i.cluster == 1
                sum2 += aux
                cont2 +=1
            else
                sum3 += aux
                cont3 +=1
            end
        end

        #llamar a la funcion mover de los centroides
        if cont1 > 0
            centroide1.mover
        if cont2 > 0
            centroide2.mover
        if cont3 > 0
            centroide3.mover
        
    end
end

def main()
    almacen = Almacen.new
    almacen.generar

    contIt = 0

    almacenCentroides = AlmacenCentroides.new
    almacenCentroides.generarCentroides

    while (almacenCentroides[i].posX == posAntX and #haz bucle hasta que todo centroide deje de moverse
        almacen.calcDistancias
        contIt +=1
    end
    
    puts "Proceso terminado luego de #{contIt.to_s} iteraciones."
end

if __FILE__ == $0
    main()
end