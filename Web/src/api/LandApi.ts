import { isAxiosError } from "axios"
import api from "../lib/axios"
import { City, LandCreate, Land, ResidentialDevelopment } from "../types"
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
    try {
        const { data } = await api.post<Land>('/land', land)
        return data
    } catch (error) {
        if(isAxiosError(error) && error.response) {
            throw new Error(error.response.data.error)
        }
    }
}
export async function updateLand(land: Land) {
    try {
        const { data } = await api.post<Land>('/land/updateLand', land)
        return data
    } catch (error) {
        if(isAxiosError(error) && error.response) {
            throw new Error(error.response.data.error)
        }
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