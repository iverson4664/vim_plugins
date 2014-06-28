#include <stdio.h>
#include "Dog.hpp"

int main(int argc, const char *argv[]) {
    Dog *d = new Dog("Fido");
    Dog *p = new Dog("Pito");
    printf("d is %s\n", d->getName());
    return 0;
}
