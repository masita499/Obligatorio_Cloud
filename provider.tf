# Se define el provider aws para que funcione todo el codigo: Con esto y el contenido de la carpeta .aws 
#el codigo sabe donde ir a parar.
provider "aws" {
    region =var.region
    profile = var.perfil
}
