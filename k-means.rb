require 'csv', 'math'

class Centroide
    attr_accessor :posX, :posY

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
    attr_accessor :sepal_length, :sepal_width, :petal_length , :petal_width, :species, :cluster

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
      for i in 0..2
        centroide = Centroide.new()
        rnd = Random.new
        centroide.posX = rnd.rand(15)
        centroide.posY = rnd.rand(15)
        arrayCentroides.push(centroide)
      end
    end
end

class Almacen < Nodo
    def initialize()
        arrayNodos = Array.new()
    end

    def generar()
        CSV.foreach("C:/Users/RoniD/Downloads/iris.csv") do |row|
            nodo = Nodo.new()
            nodo.sepal_length = row[0].to_i
            nodo.sepal_width = row[1].to_i
            nodo.petal_length = row[2].to_i
            nodo.petal_width = row[3].to_i
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
            centroide1.mover(sum1,cont1)
        end

        if cont2 > 0
            centroide2.mover(sum2,cont2)
        end

        if cont3 > 0
            centroide3.mover(sum3,cont3)
        end
        
    end
end

def main()
    almacen = Almacen.new
    almacen.generar

    contIt = 0

    posAntX0 = nil
    posAntY0 = nil

    posAntX1 = nil
    posAntY1 = nil

    posAntX2 = nil
    posAntY2 = nil

    almacenCentroides = AlmacenCentroides.new
    almacenCentroides.generarCentroides

    while (((almacenCentroides[0].posX != posAntX0) or (almacenCentroides[0].posY != posAntY0)) or ((almacenCentroides[1].posX != posAntX1) or (almacenCentroides[1].posY != posAntY1)) or ((almacenCentroides[2].posX != posAntX2) or (almacenCentroides[2].posY != posAntY2)))   #haz bucle hasta que todo centroide deje de moverse
        #guarda la posicion de cada centroide antes de realizar operaciones
        posAntX0 = almacenCentroides[0].posX 
        posAntY0 = almacenCentroides[0].posY

        posAntX1 = almacenCentroides[1].posX
        posAntY1 = almacenCentroides[1].posY

        posAntX2 = almacenCentroides[2].posX
        posAntY2 = almacenCentroides[2].posY

        #realiza operaciones 
        almacen.calcDistancias(almacenCentroides.arrayCentroides)

        #aumenta el contador de iteraciones en 1
        contIt +=1
    end
    
    puts "Proceso terminado luego de #{contIt.to_s} iteraciones."
end

if __FILE__ == $0
    main()
end
