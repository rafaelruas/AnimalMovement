﻿namespace DataModel
{
    public partial class Animal
    {
        public override string ToString()
        {
            return _ProjectId + "/" + _AnimalId;
        }
    }
}