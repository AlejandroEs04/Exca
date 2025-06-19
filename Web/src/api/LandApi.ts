import { isAxiosError } from "axios"
import api from "../lib/axios"
import { City, LandCreate, Land, ResidentialDevelopment, PropertyTax } from "../types"
import {
  State,
  LandType,
  LandCategory,
  Owner,
  LandStatus,
} from "../types";

export async function getLands() {
  try {
      const { data } = await api<Land[]>('/land')
      return data
  } catch (error) {
      if(isAxiosError(error) && error.response) {
          throw new Error(error.response.data.error)
      }
  }
}

export async function registerLand(land: LandCreate) {
  console.log("REGISTRANDO LAND", land);
  try {
    const { data } = await api.post<Land>('/land', land);
    return data;
  } catch (error) {
    if (isAxiosError(error) && error.response) {
      console.error("Error detalle completo:", error.response.data); // 👈 aquí
      throw new Error(JSON.stringify(error.response.data, null, 2)); // ← esto muestra en el toast todos los errores bien formateados
    }
    throw new Error("Error desconocido al registrar terreno.");
  }
}


export async function updateLand(land: LandCreate & { id: number }) {
    try {
        const { data } = await api.put<Land>('/land', land)
        return data
    } catch (error) {
        if(isAxiosError(error) && error.response) {
            throw new Error(error.response.data.error)
        }
    }
}
export async function getLandById(id: number): Promise<Land> {
  try {
    const { data } = await api.get<Land>(`/land/getLandById/${id}`);
    return data;
  } catch (error) {
    if (isAxiosError(error) && error.response) {
      throw new Error(error.response.data.error);
    }
    throw new Error("Error al obtener terreno");
  }
}
export async function getPropertyTaxesByLandId(id: number): Promise<PropertyTax[]> {
  try {
    const { data } = await api<PropertyTax[]>(`/land/${id}/property-taxes`)
    return data
  } catch (error) {
    if (isAxiosError(error) && error.response) {
      
      const msg =
        (error.response.data as any).detail ??
        (error.response.data as any).error ??
        'Error fetching property taxes'
      throw new Error(msg)
    }
    // para cualquier otro tipo de excepción
    throw new Error('Unexpected error fetching property taxes')
  }
}


export async function getResidentialDevelopments () {
    try {
        const { data } = await api<ResidentialDevelopment[]>('/residential-developments')
        return data
    } catch (error) {
        if(isAxiosError(error) && error.response) {
            throw new Error(error.response.data.error)
        }
    }
}
export async function getCities () {
    try {
        const { data } = await api<City[]>('/cities')
        return data
    } catch (error) {
        if(isAxiosError(error) && error.response) {
            throw new Error(error.response.data.error)
        }
    }
}

// New functions:

export async function getStates() {
  try {
    const { data } = await api.get<State[]>("/states");
    return data;
  } catch (error) {
    if (isAxiosError(error) && error.response) {
      throw new Error(error.response.data.detail || error.message);
    }
  }
}

export async function getLandTypes() {
  try {
    const { data } = await api.get<LandType[]>("/land-types");
    return data;
  } catch (error) {
    if (isAxiosError(error) && error.response) {
      throw new Error(error.response.data.detail || error.message);
    }
  }
}

export async function getCategories() {
  try {
    const { data } = await api.get<LandCategory[]>("/land-categories");
    return data;
  } catch (error) {
    if (isAxiosError(error) && error.response) {
      throw new Error(error.response.data.detail || error.message);
    }
  }
}

export async function getCompanies() {
  try {
    const { data } = await api.get<Owner[]>("/owner");
    return data;
  } catch (error) {
    if (isAxiosError(error) && error.response) {
      throw new Error(error.response.data.detail || error.message);
    }
  }
}

export async function getStatuses() {
  try {
    const { data } = await api.get<LandStatus[]>("/land-statuses");
    return data;
  } catch (error) {
    if (isAxiosError(error) && error.response) {
      throw new Error(error.response.data.detail || error.message);
    }
  }
}